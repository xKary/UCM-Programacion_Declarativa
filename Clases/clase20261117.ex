####### Listas de comprensión

# for x <- 1..5 do
#   x * 2
# end

# for x <- 1..5, y <- 1..x do
#   {x, y}
# end

# for x <- 1..5, y <- %{a: 1, b: 5} do
#   {x, y}
# end

# for x <- 1..10, rem(x, 2) == 0 do
#   x
# end
# 1..10 |> Enum.filter(&rem(&1,2)==0) |> Enum.map(&(&1*&1))

# for x <- 1..5, y <- 1..x do
#   {x, y}
# end
# 1..5 |> Enum.flat_map(fn x -> 1..x |> Enum.map(fn y -> {x, y} end) end)

# for x <- 1..5, y <- 1..x, into: %{} do
#   {x, y}
# end

# for x <- 1..5, y <- 1..x, reduce: 0 do
#   ac -> ac + x + y
# end

defmodule ListasIntensionales do
  def ternas(n) do
    for a <- 1..n, b <- a..n, c <- 1..n, a * a + b * b == c * c do
      {a, b, c}
    end
  end

  def reinas(_, 0, _, _, _), do: [[]]

  def reinas(n, l, col_ocupadas, diag_asc_ocupadas, diag_desc_ocupadas) do
    for x <- 1..n,
        fila = n - l + 1,
        diag = fila + x,
        x not in col_ocupadas,
        diag not in diag_asc_ocupadas,
        diag_desc = fila - x,
        diag_desc not in diag_desc_ocupadas,
        xs <- reinas(n,
                     l - 1,
                     MapSet.put(col_ocupadas, x),
                     MapSet.put(diag_asc_ocupadas, diag),
                     MapSet.put(diag_desc_ocupadas, diag_desc)) do
        [x | xs]
    end
  end

  def reinas(n), do: reinas(n, n, MapSet.new(), MapSet.new(), MapSet.new())
end
