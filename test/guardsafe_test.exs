defmodule GuardsafeTest do
  use ExUnit.Case

  defmodule When do
    import Guardsafe
    require Integer

    def using_divisible_by?(number, divisor) when divisible_by?(number, divisor), do: true
    def using_divisible_by?(number, divisor) when not divisible_by?(number, divisor), do: false

    def using_function_with_arity?(term) when function?(term, 1), do: true
    def using_function_with_arity?(term) when not function?(term, 1), do: false

    ~w(atom binary bitstring boolean integer float function list map nil number pid port reference tuple
       even odd)
    |> Enum.each fn(type) ->
      def unquote(String.to_atom "using_#{type}?")(term) when unquote(String.to_atom "#{type}?")(term), do: true
      def unquote(String.to_atom "using_#{type}?")(term) when not unquote(String.to_atom "#{type}?")(term), do: false
    end
  end

  test "divisible_by?" do
    assert When.using_divisible_by?(10, 2)
    refute When.using_divisible_by?(11, 2)
  end

  test "atom?" do
    assert When.using_atom?(:infinity)
    refute When.using_atom?("hello")
  end

  test "binary?" do
    assert When.using_binary?(<< 0, 1, 2, 3 >>)
    assert When.using_binary?("hello")
    refute When.using_binary?('hello')
  end

  test "bitstring?" do
    assert When.using_bitstring?(<< 1 :: size(1) >>)
    refute When.using_bitstring?(1)
  end

  test "boolean?" do
    assert When.using_boolean?(false)
    refute When.using_boolean?("false")
  end

  test "float?" do
    assert When.using_float?(9.0)
    refute When.using_float?(123)
  end

  test "function?" do
    assert When.using_function?(fn -> end)
    refute When.using_function?(:not_a_function)
  end

  test "function? with arity" do
    assert When.using_function_with_arity?(fn(_) -> end)
    refute When.using_function_with_arity?(fn -> end)
  end

  test "integer?" do
    assert When.using_integer?(123)
    refute When.using_integer?(9.0)
  end

  test "list?" do
    assert When.using_list?([1, 2, 3])
    refute When.using_list?({:a, :tuple})
  end

  test "map?" do
    assert When.using_map?(%{key: :value})
    refute When.using_map?([key: :value])
  end

  test "nil?" do
    assert When.using_nil?(nil)
    refute When.using_nil?(1)
  end

  test "number?" do
    assert When.using_number?(1)
    assert When.using_number?(1.0)
    refute When.using_nil?("1")
  end

  test "pid?" do
    assert When.using_pid?(self)
    refute When.using_pid?("self")
  end

  test "port?" do
    assert When.using_port?(hd :erlang.ports)
    refute When.using_port?(self)
  end

  test "reference?" do
    assert When.using_reference?(make_ref)
    refute When.using_reference?(self)
  end

  test "tuple?" do
    assert When.using_tuple?({:a, :tuple})
    refute When.using_tuple?(nil)
  end

  test "even?" do
    assert When.using_even?(2)
    refute When.using_even?(1)
  end

  test "odd?" do
    assert When.using_odd?(1)
    refute When.using_odd?(2)
  end
end
