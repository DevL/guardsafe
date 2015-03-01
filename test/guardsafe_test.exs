defmodule GuardsafeTest do
  use ExUnit.Case

  defmodule When do
    import Guardsafe

    def using_divisible_by?(number, divisor) when divisible_by?(number, divisor), do: true
    def using_divisible_by?(number, divisor) when not divisible_by?(number, divisor), do: false

    def using_atom?(term) when atom?(term), do: true
    def using_atom?(term) when not atom?(term), do: false

    def using_binary?(term) when binary?(term), do: true
    def using_binary?(term) when not binary?(term), do: false

    def using_bitstring?(term) when bitstring?(term), do: true
    def using_bitstring?(term) when not bitstring?(term), do: false

    def using_boolean?(term) when boolean?(term), do: true
    def using_boolean?(term) when not boolean?(term), do: false

    def using_integer?(term) when integer?(term), do: true
    def using_integer?(term) when not integer?(term), do: false

    def using_float?(term) when float?(term), do: true
    def using_float?(term) when not float?(term), do: false

    def using_list?(term) when list?(term), do: true
    def using_list?(term) when not list?(term), do: false

    def using_list?(term) when list?(term), do: true
    def using_list?(term) when not list?(term), do: false

    def using_map?(term) when map?(term), do: true
    def using_map?(term) when not map?(term), do: false

    def using_nil?(term) when nil?(term), do: true
    def using_nil?(term) when not nil?(term), do: false

    def using_number?(term) when number?(term), do: true
    def using_number?(term) when not number?(term), do: false

    def using_tuple?(term) when tuple?(term), do: true
    def using_tuple?(term) when not tuple?(term), do: false
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

  test "tuple?" do
    assert When.using_tuple?({:a, :tuple})
    refute When.using_tuple?(nil)
  end
end
