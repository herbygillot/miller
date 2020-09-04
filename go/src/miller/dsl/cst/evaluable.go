package cst

import (
	"errors"

	"miller/dsl"
)

// ================================================================
// This handles anything on the right-hand sides of assignment statements.
// (Also, computed field names on the left-hand sides of assignment
// statements.)
// ================================================================

// ----------------------------------------------------------------
func BuildEvaluableNode(astNode *dsl.ASTNode) (IEvaluable, error) {
	if astNode.Children == nil {
		return BuildEvaluableLeafNode(astNode)
	}

	if astNode.Type == dsl.NodeTypeOperator {
		return BuildOperatorNode(astNode)
	}

	if astNode.Type == dsl.NodeTypeArrayLiteral {
		return BuildArrayLiteralNode(astNode)
	}

	if astNode.Type == dsl.NodeTypeMapLiteral {
		return BuildMapLiteralNode(astNode)
	}

	if astNode.Type == dsl.NodeTypeArrayOrMapIndexAccess {
		return BuildPanicNode(), nil // xxx temp
	}
	if astNode.Type == dsl.NodeTypeArraySliceAccess {
		return BuildPanicNode(), nil // xxx temp
	}
	if astNode.Type == dsl.NodeTypeArraySliceEmptyLowerIndex {
		return BuildPanicNode(), nil // xxx temp
	}
	if astNode.Type == dsl.NodeTypeArraySliceEmptyUpperIndex {
		return BuildPanicNode(), nil // xxx temp
	}

	// xxx if/while/etc
	// xxx function
	// xxx more

	return nil, errors.New("CST builder: unhandled AST node type " + string(astNode.Type))
}
