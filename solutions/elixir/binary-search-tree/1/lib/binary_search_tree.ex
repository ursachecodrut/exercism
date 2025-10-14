defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(bst_node, data) do
    if data <= bst_node.data do
      case bst_node.left do
        nil -> %{bst_node | left: new(data)}
        left -> %{bst_node | left: insert(left, data)}
      end
    else
      case bst_node.right do
        nil -> %{bst_node | right: new(data)}
        right -> %{bst_node | right: insert(right, data)}
      end
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    in_order(tree, [])
  end

  defp in_order(tree, acc) do
    if tree == nil do
      acc
    else
      in_order(tree.left, acc) ++ [tree.data] ++ in_order(tree.right, acc)
    end
  end
end
