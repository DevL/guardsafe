defmodule Guardsafe do
  @vsn "0.3.0"
  @doc false
  def version, do: @vsn

  @moduledoc """
  Provides readability-enhancing macros that can safely be used in guard clauses.

  ## Examples

      def double(number) when nil?(number), do: 0

      iex> import Guardsafe
      nil
      iex> nil |> nil?
      true
      iex> [] |> tuple?
      false
      iex> require Integer
      nil
      iex> even? 2
      true
  """

  @doc """
  Expands `divisible_by?(number, divisor)` into `rem(number, divisor) == 0`

  ## Examples

      iex> 25 |> divisible_by? 5
      true
  """
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end

  require_warning = fn(module) ->
    unless module == Kernel, do: "\n\nRemember to `require #{module}` before use."
  end

  generate_predicates = fn({module, types}) ->
    @module String.to_atom "Elixir.#{module}"
    types
    |> Enum.each fn(type) ->
      @predicate String.to_atom("#{type}?")
      @function String.to_atom("is_#{type}")

      @doc """
      Expands `#{@predicate}(term)` into `#{module}.#{@function}(term)`.
      #{require_warning.(@module)}

      ## Examples

          iex> some_#{type}_variable |> #{@predicate}
          true
      """
      defmacro unquote(@predicate)(term) do
        quote do
          unquote(@module) . unquote(@function)(unquote(term))
        end
      end
    end
  end

  [
    Kernel: ~w(atom binary bitstring boolean float function integer list map nil number pid port reference tuple),
    Integer: ~w(even odd),
  ]
  |> Enum.each generate_predicates

  @doc """
  Expands `function?(term, arity)` into `is_function(term, arity)`

  ## Examples

      iex> &String.to_integer/1 |> function?(2)
      false
  """
  defmacro function?(term, arity) do
    quote do
      is_function(unquote(term), unquote(arity))
    end
  end
end
