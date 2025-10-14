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
  def insert(nil, data), do: new(data)

  def insert(bst_node, data) when data <= bst_node.data,
    do: %{bst_node | left: insert(bst_node.left, data)}

  def insert(bst_node, data) when data > bst_node.data,
    do: %{bst_node | right: insert(bst_node.right, data)}

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(bst_node) do
    in_order(bst_node.left) ++ [bst_node.data] ++ in_order(bst_node.right)
  end
end
