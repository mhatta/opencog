# Check if relex is reachable.
# TODO:
# 1. Port this to FindRelex.cmake or find_service function to be used for
#    other services too.
# 2. Make it not depend on guile
IF(HAVE_GUILE)
  SET(RELEX_UTILS "${PROJECT_SOURCE_DIR}/opencog/nlp/scm/relex-utils.scm")
  SET(CHECK_RELEX "
    (define loaded (catch #t (lambda () (load \"${RELEX_UTILS}\") #t)
      (lambda (e . args) #f)))
    (if (and (defined? 'set-relex-server-host) (defined? 'relex-reachable?)
          loaded)
      (begin (set-relex-server-host) (display (relex-reachable?)))
      (display \"config-error\"))")
  # The warning from guile during compilation of relex-utils.scm is ignored,
  # because it doesn't affect the usage of the functions.
  EXECUTE_PROCESS(COMMAND guile -q -c "${CHECK_RELEX}"
    OUTPUT_VARIABLE RELEX_REACHABLE
    OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_QUIET)
ENDIF()

IF("${RELEX_REACHABLE}" STREQUAL "#t")
  ADD_GUILE_TEST(GhostProcedureTest test-ghost-procedures.scm)
ELSEIF("${RELEX_REACHABLE}" STREQUAL "config-error")
  message(FATAL_ERROR "Issue with relex utilities or the file ${RELEX_UTILS}")
ENDIF()