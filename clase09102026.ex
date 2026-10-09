# elixir "file.es"
# iex
# c "file.ex"
defmodule Lista do
    def len([]), do: 0
    def len(xs), do: 1 + len(tl(xs))

    def sum([]), do: 0
    def sum([x | xs]), do: x + sum(xs)

    def member?([], _), do: false
    def member?([x | _], x), do: true
    def member?([_ | xs], y), do: member?(xs, y)

    def last([x]), do: x
    def last([_ | xs]), do: last(xs)

    def at([x | _], 0), do: x
    def at([_ | xs], n) when n > 0 do
        at(xs, n - 1)
    end

    def append([], ys), do: ys
    def append(xs, []), do: xs
    def append([x | xs], ys) do
      [x | append(xs, ys)]
    end

    # Complejidad: O(n^2)
    # n(n-1)/2
    def reverse([]), do: []
    def reverse([x | xs]), do: reverse(xs) ++ [x]

    # Complejidad: O(n)
    def reverse2(xs), do: reverse2(xs, [])
    defp reverse2([], ac), do: ac
    defp reverse2([x | xs], []) do
      reverse2(xs, [x])
    end
    defp reverse2([x | xs], acc) do
      reverse2(xs, [x | acc])
    end

    def take(_, 0), do: []
    def take([x | xs], n) when n > 0 do
      [x | take(xs, n - 1)]
    end
    def take([], _), do: []

    def zip(xs, []), do: xs
    def zip([], ys), do: ys
    def zip([x | xs], [y | ys]) do
      [{x, y} | zip(xs, ys)]
    end

end
