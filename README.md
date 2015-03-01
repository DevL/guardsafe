# Guardsafe

[![Build Status](https://travis-ci.org/DevL/guardsafe.svg?branch=master)](https://travis-ci.org/DevL/guardsafe)
[![Inline docs](http://inch-ci.org/github/DevL/guardsafe.svg?branch=master)](http://inch-ci.org/github/DevL/guardsafe)
[![Hex.pm](https://img.shields.io/hexpm/v/guardsafe.svg)](https://hex.pm/packages/guardsafe)

Macros expanding into code that can be safely used in guard clauses.

## Usage

Update your `mix.exs` file and run `mix deps.get`.
```elixir
defp deps do
  [{:guardsafe, "~> 0.2.0"}]
end
```

Import all the macros...
```elixir
defmodule MyModule do
  import Guardsafe
```

...or just the ones you need.
```elixir
defmodule MyOtherModule do
  import Guardsafe, only: [divisible_by?: 2]
```

Now go forth and make your guard clauses more readable!
```elixir
def leap_year?(year) when not integer?(year), do: raise "That's not a proper year!"
def leap_year?(year) when divisible_by?(year, 400), do: true
def leap_year?(year) when divisible_by?(year, 100), do: false
def leap_year?(year), do: divisible_by?(year, 4)
```

Documentation for each macro is of course available in `iex`.
```
iex(1)> h Guardsafe.divisible_by?

                    defmacro divisible_by?(number, divisor)

Expands divisible_by?(number, divisor) into rem(number, divisor) == 0
```

## Available macros

* `divisible_by?/2` - checks whether two integers are evenly divisible.
* atom?/1 - translates into is_atom/1
* binary?/1 - translates into is_binary/1
* bitstring?/1 - translates into is_bitstring/1
* boolean?/1 - translates into is_boolean/1
* float?/1 - translates into is_float/1
* integer?/1 - translates into is_integer/1
* list?/1 - translates into is_list/1
* map?/1 - translates into is_map/1
* nil?/1 - translates into is_nil/1
* number?/1 - translates into is_number/1
* pid?/1 - translates into is_pid/1
* tuple?/1 - translates into is_tuple/1

## Not yet available macros

* function?/1 - translates into is_function/1
* function?/2 - translates into is_function/2
* port?/1 - translates into is_port/1
* reference?/1 - translates into is_reference/1

## Online documentation

For more information, see [the full documentation](http://hexdocs.pm/guardsafe/).
