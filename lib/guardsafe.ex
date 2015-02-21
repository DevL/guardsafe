defmodule Guardsafe do
  @moduledoc """
  Provides readability-enhancing macros that can safely be used in guard clauses.
  """

  @doc """
  Expands `divisible_by?(number, divisor)` into `rem(number, divisor) == 0`
  """
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end
end

