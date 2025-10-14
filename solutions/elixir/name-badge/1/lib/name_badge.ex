defmodule NameBadge do
  def print(id, name, department) do
    department = if department, do: department, else: "owner"
    emp_id = if id, do: "[#{id}] - ", else: ""
    emp_id <> "#{name} - #{String.upcase(department)}"
  end
end
