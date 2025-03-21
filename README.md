# Guardsafe

**NB:** This repository has been moved to [https://codeberg.org/DevL/guardsafe](https://codeberg.org/DevL/guardsafe).

[![Build Status](https://travis-ci.org/DevL/guardsafe.svg?branch=master)](https://travis-ci.org/DevL/guardsafe)
[![Inline docs](http://inch-ci.org/github/DevL/guardsafe.svg?branch=master)](http://inch-ci.org/github/DevL/guardsafe)
[![Hex.pm](https://img.shields.io/hexpm/v/guardsafe.svg)](https://hex.pm/packages/guardsafe)
[![Documentation](https://img.shields.io/badge/Documentation-online-c800c8.svg)](http://hexdocs.pm/guardsafe)

Macros expanding into code that can be safely used in guard clauses.

## Usage

Update your `mix.exs` file and run `mix deps.get`.
```elixir
defp deps do
  [{:guardsafe, "~> 0.5.0"}]
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
  import Guardsafe, only: [divisible_by?: 2, integer?: 1]
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

**NB:** If a macro is translated into a function residing in another module
than `Kernel` you need to require it before use, e.g. `require Integer`.

#### Macros for checking types
* `atom?/1` - translates into `Kernel.is_atom/1`
* `binary?/1` - translates into `Kernel.is_binary/1`
* `bitstring?/1` - translates into `Kernel.is_bitstring/1`
* `boolean?/1` - translates into `Kernel.is_boolean/1`
* `float?/1` - translates into `Kernel.is_float/1`
* `function?/1` - translates into `Kernel.is_function/1`
* `function?/2` - translates into `Kernel.is_function/2`
* `integer?/1` - translates into `Kernel.is_integer/1`
* `list?/1` - translates into `Kernel.is_list/1`
* `map?/1` - translates into `Kernel.is_map/1`
* `nil?/1` - translates into `Kernel.is_nil/1`
* `number?/1` - translates into `Kernel.is_number/1`
* `pid?/1` - translates into `Kernel.is_pid/1`
* `port?/1` - translates into `Kernel.is_port/1`
* `reference?/1` - translates into `Kernel.is_reference/1`
* `tuple?/1` - translates into `Kernel.is_tuple/1`

#### Macros for checking values
* `divisible_by?/2` - checks whether two integers are evenly divisible.
* `even?/1` - returns true for even integers.
* `odd?/1` - returns true for odd integers.
* `within?/3` - checks whether a value is in the range of the last two arguments.

#### Macros for dates and times
* `date?/1` - checks if the term is an Erlang-style date tuple.
* `datetime?/1` - checks if the term is an Erlang-style datetime tuple.
* `time?/1` - checks if the term is an Erlang-style time tuple.

_These can come in handy when working with a library such as [GoodTimes](https://github.com/DevL/good_times)._

### Why nil? and float? instead of is_nil and is_float

While the Elixir core team thinks that `nil?` compared to `is_nil` is [an inconcistency](https://groups.google.com/forum/#!topic/elixir-lang-core/FaKJstePFV0), others, especially Rubyists, might be more comfortable with the `nil?` notation. Honestly though, this is mostly intended as a display of how Elixir's metaprogramming capabilities can be used to shape the look and feel of the language itself.

## Online documentation

For more information, see [the full documentation](http://hexdocs.pm/guardsafe).

## Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b quis-custodiet-ipsos-custodes`)
3. Commit your changes (`git commit -am 'Guards! Guards!'`)
4. Push to the branch (`git push origin quis-custodiet-ipsos-custodes`)
5. Create a new Pull Request
