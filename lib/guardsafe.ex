defmodule Guardsafe do
  @vsn "0.5.0"
  @doc false
  def version, do: @vsn

  @moduledoc """
  Provides readability-enhancing macros that can safely be used in guard clauses.

  ## Examples

      defmodule MacrofyAllTheThings do
        import Guardsafe
        require Integer

        def magic(number) when number |> nil? do
          "Staring into the void..."
        end

        def magic(number) when number |> even? do
          "That's not odd."
        end

        def magic(number) when number |> divisible_by?(5) do
          "High five!"
        end
      end

      iex> MacrofyAllTheThings.magic(8)
      "That's not odd."
  """
  @doc """
  Returns true if the integer number is evenly divisible by the divisor.

  ## Examples

      iex> 25 |> divisible_by?(5)
      true
  """
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end

  @doc """
  Returns true for even integers.

  ## Examples

      iex> even? 7
      false
  """
  defmacro even?(number) do
    quote do
      divisible_by?(unquote(number), 2)
    end
  end

  @doc """
  Returns true for odd integers.

  ## Examples

      iex> odd? 5
      true
  """
  defmacro odd?(number) do
    quote do
      not even?(unquote(number))
    end
  end

  require_warning = fn(module) ->
    unless module == Kernel, do: "\n\nRemember to `require #{module}` before use."
  end

  generate_predicates = fn({module, types}) ->
    @module String.to_atom "Elixir.#{module}"
    types
    |> Enum.each(fn(type) ->
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
          unquote(@module).unquote(@function)(unquote(term))
        end
      end
    end)
  end

  @doc """
  Returns true if the term is between the low and high values, inclusively.

  ## Examples

      iex> 5 |> within?(2, 10)
      true
  """
  defmacro within?(term, low, high) do
    quote do
      unquote(low) <= unquote(term) and unquote(term) <= unquote(high)
    end
  end

  @doc """
  Returns true if the term is considered to be a date tuple.

  The date is not checked for validity other than the months being in
  the 1..12 range and the days being in the 1..31 range.

  ## Examples

      iex> 5 |> date?({2015, 3, 20})
      true
  """
  defmacro date?(term) do
    quote do
      is_tuple(unquote(term))
      and (tuple_size(unquote(term)) == 3)
      and is_integer(elem(unquote(term), 0))
      and is_integer(elem(unquote(term), 1))
      and (elem(unquote(term), 1) |> within?(1, 12))
      and is_integer(elem(unquote(term), 2))
      and (elem(unquote(term), 2) |> within?(1, 31))
    end
  end

  @doc """
  Returns true if the term is considered to be a time tuple.

  The time is not checked for validity other than the hours being in
  the 0..23 range and the minutes and seconds being in the 0..59 range.

  ## Examples

      iex> 5 |> time?({15, 33, 42})
      true
  """
  defmacro time?(term) do
    quote do
      is_tuple(unquote(term))
      and (tuple_size(unquote(term)) == 3)
      and is_integer(elem(unquote(term), 0))
      and (elem(unquote(term), 0) |> within?(0, 23))
      and is_integer(elem(unquote(term), 1))
      and (elem(unquote(term), 1) |> within?(0, 59))
      and is_integer(elem(unquote(term), 2))
      and (elem(unquote(term), 2) |> within?(0, 59))
    end
  end

  @doc """
  Returns true if the term is considered to be a time tuple.

  `date?` and `time?` are used for checking and validating the
  date and time portions of the datetime.

  ## Examples

      iex> datetime? {{2015, 3, 20}, {15, 33, 42}}
      true
  """
  defmacro datetime?(term) do
    quote do
      is_tuple(unquote(term))
      and (tuple_size(unquote(term)) == 2)
      and date?(elem(unquote(term), 0))
      and time?(elem(unquote(term), 1))
    end
  end

  [
    Kernel: ~w(atom binary bitstring boolean float function integer list map nil number pid port reference tuple),
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
