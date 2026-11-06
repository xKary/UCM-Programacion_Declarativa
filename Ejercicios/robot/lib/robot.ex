defmodule Robot do
  # Hoja 1 Ejercicio 24
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

  # Hoja 1 Ejercicio 26
  def media_edades_fumadores(nombre_fichero, valor_defecto) do
    lista_edades = File.stream!(nombre_fichero)
    |> CSV.decode!()
    |> Stream.drop(1)
    |> Stream.filter(fn [_,_,fumador,_] -> fumador == "SI" end)
    |> Enum.map(fn [_,edad,_,_] -> String.to_integer(edad) end)
    |> Enum.take(10)

    if Enum.empty?(lista_edades) do
      valor_defecto.()
    else
      Enum.sum(lista_edades) / Enum.count(lista_edades)
    end
  end

  # Hoja 1 Ejercicio 27
  def exp(x,n) do
    pots = Stream.iterate(1, &(&1 * x))
    facts = Stream.iterate({1,0},
                           fn {f, n} -> {f * (n + 1), n + 1} end)
                           |> Stream.map(fn {f,_} -> f end)
    Stream.zip_with(pots,facts, &(&1/&2))
    |> Stream.take(n)
    |> Enum.sum()
  end

end
