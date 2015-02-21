defmodule GuardsafeTest do
  use ExUnit.Case

  defmodule When do
    import Guardsafe

    def using_divisible_by?(number, divisor) when divisible_by?(number, divisor), do: true
    def using_divisible_by?(number, divisor) when not divisible_by?(number, divisor), do: false
  end

  test "divisible_by?" do
    assert When.using_divisible_by?(10, 2)
    refute When.using_divisible_by?(11, 2)
  end
end
