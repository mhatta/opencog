;; Returning children associated with current target.

(define getChildren
    (BindLink
        (ListLink
            (TypedVariableLink
                (VariableNode "$relationshipNode")
                (ListLink
                    (TypeNode "DefinedLinguisticRelationshipNode")
                    (TypeNode "PrepositionalRelationshipNode")
                )
            )
            (VariableNode "$target")
            (VariableNode "$child")
        )
        (ImplicationLink
            (AndLink
                (ListLink
                    (AnchorNode "CurrentTarget")
                    (VariableNode "$target")
                )
                (EvaluationLink
                    (VariableNode "$relationshipNode")
                    (ListLink
                        (VariableNode "$target")
                        (VariableNode "$child")
                    )
                )
            )
            (ListLink
                (AnchorNode "CurrentResult")
                (VariableNode "$child")
            )
        )
    )
)
