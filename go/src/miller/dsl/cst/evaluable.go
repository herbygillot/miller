// ================================================================
// This handles anything on the right-hand sides of assignment statements.
// (Also, computed field names on the left-hand sides of assignment
// statements.)
// ================================================================

package cst

import (
	"errors"
	"fmt"
	"os"

	"miller/dsl"
	"miller/lib"
	"miller/types"
)

// ----------------------------------------------------------------
func (this *RootNode) BuildEvaluableNode(astNode *dsl.ASTNode) (IEvaluable, error) {

	if astNode.Children == nil {
		return this.BuildLeafNode(astNode)
	}

	switch astNode.Type {

	case dsl.NodeTypeArrayLiteral:
		return this.BuildArrayLiteralNode(astNode)

	case dsl.NodeTypeMapLiteral:
		return this.BuildMapLiteralNode(astNode)

	case dsl.NodeTypeArrayOrMapIndexAccess:
		return this.BuildArrayOrMapIndexAccessNode(astNode)

	case dsl.NodeTypeArraySliceAccess:
		return this.BuildArraySliceAccessNode(astNode)

	case dsl.NodeTypeIndirectFieldValue:
		return this.BuildIndirectFieldValueNode(astNode)

	case dsl.NodeTypeEnvironmentVariable:
		return this.BuildEnvironmentVariableNode(astNode)

	// Operators are just functions with infix syntax so we treat them like
	// functions in the CST.
	case dsl.NodeTypeOperator:
		return this.BuildFunctionCallsiteNode(astNode)
	case dsl.NodeTypeFunctionCallsite:
		return this.BuildFunctionCallsiteNode(astNode)

	}

	return nil, errors.New(
		"CST BuildEvaluableNode: unhandled AST node type " + string(astNode.Type),
	)
}

// ----------------------------------------------------------------
type IndirectFieldValueNode struct {
	fieldNameEvaluable IEvaluable
}

func (this *RootNode) BuildIndirectFieldValueNode(
	astNode *dsl.ASTNode,
) (*IndirectFieldValueNode, error) {
	lib.InternalCodingErrorIf(astNode.Type != dsl.NodeTypeIndirectFieldValue)
	lib.InternalCodingErrorIf(astNode.Children == nil)
	lib.InternalCodingErrorIf(len(astNode.Children) != 1)
	fieldNameEvaluable, err := this.BuildEvaluableNode(astNode.Children[0])
	if err != nil {
		return nil, err
	}
	return &IndirectFieldValueNode{
		fieldNameEvaluable: fieldNameEvaluable,
	}, nil
}
func (this *IndirectFieldValueNode) Evaluate(state *State) types.Mlrval { // xxx err
	fieldName := this.fieldNameEvaluable.Evaluate(state)
	if fieldName.IsAbsent() {
		return types.MlrvalFromAbsent()
	}

	// Positional indices are supported, e.g. $[3] is the third field in the record.
	value, err := state.Inrec.GetWithMlrvalIndex(&fieldName)
	if err != nil {
		// Key isn't int or string.
		// xxx needs error-return in the API
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if value == nil {
		// E.g. $[7] but there aren't 7 fields in this record.
		return types.MlrvalFromAbsent()
	}
	return *value
}
