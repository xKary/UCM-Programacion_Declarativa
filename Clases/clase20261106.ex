defmodule Robot do
  @map_size 10

  def move({x,y}, :norte) when y < @map_size, do: {:ok, {x,y + 1}}
  def move({x,y}, :sur) when y > 1, do: {:ok, {x,y - 1}}
  def move({x,y}, :este) when x < @map_size, do: {:ok, {x + 1 ,y}}
  def move({x,y}, :oeste) when x > 1, do: {:ok, {x - 1 ,y}}
  def move(_,_), do: :error

  def move_list(pos, []), do: {:ok,pos}
  def move_list(pos, [dir | dirs]) do
    with {:ok, pos1} <- move(pos, dir) do
         move_list(pos1, dirs)
        end
  end

end

defmodule Lazy do
  # Lazy.cond(2>1,fn ->  "s" end,fn -> 1/0 end)
  def cond(true, f1, _), do: f1.()
  def cond(false, _, f2), do: f2.()

  def multiplica_por_tres(n) do
    IO.puts("Multiplico #{n} por tres")
    n*3
  end

  def es_par(n) do
    IO.puts("Compruebo si #{n} es par")
    rem(n,2) == 0
  end

  def con_lista() do
    1..15
    |> Enum.map(&multiplica_por_tres/1)
    |> Enum.filter(&es_par/1)
  end

  def con_streams() do
    1..15
    |> Stream.map(&multiplica_por_tres/1)
    |> Stream.filter(&es_par/1)
  end

  # Stream. repeatedly(fn -> :rand.uniform(100) end) |> Enum.take(10)
  # Stream.cycle([:a, :b]) |> Enum.take(10)
  # Stream.iterate(1, &(&1*2)) |> Enum.take(10)
  # Stream.unfold(1, fn ac ->{ac + 1, ac*2} end) |> Enum.take(10)

end
