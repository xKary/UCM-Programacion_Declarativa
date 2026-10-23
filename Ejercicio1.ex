# -----------------------------------------
# Programación Declarativa Aplicada
# Ejercicio de evaluación continua 1
# -----------------------------------------
#
# IMPORTANTE: No olvides indicar tu nombre y apellidos en la siguiente línea
#
# Nombre y Apellidos: Karina Vianey Prado Oropeza

defmodule Ejercicio1 do
  # Ejercicio 1
  def keydelete(xs, k), do: keydelete(xs, k, [])
  def keydelete([{x,v} | xs], k, acc) do
    if x != k do
      keydelete(xs, k, [{x,v} | acc])
    else
      acc ++ xs
    end
  end

  # Ejercicio 2
  def with_index([],_, acc), do: Enum.reverse(acc)
  def with_index(xs), do: with_index(xs, 0, [])
  def with_index([x | xs], n, acc), do: with_index(xs, n + 1, [{x, n} | acc])

  def last_pos(xs, x) do
    index = with_index(xs)
    Enum.reduce(index, nil, fn {key, val}, acc ->
      if key == x do
        val
      else
        acc
      end
    end)
  end


  # Ejercicio 3
  def num_hermanos_mayores([x | xs]), do: Enum.count(Enum.zip([x | xs], xs), fn {a,b} -> b > a end)

  # Ejercicio 4
  def mayores_de_edad([{name, age,salary} | ps]) do
    ys = Enum.filter([{name, age,salary} | ps], fn {name, age,salary} -> age >= 18 end)
    Enum.map(ys,  fn {name, age,salary} -> name end )
  end

  def suma_sueldos([{name, age,salary} | ps]) do
    ys = Enum.filter([{name, age,salary} | ps], fn {name, age,salary} -> age >= 21 end)
    Enum.reduce(ys, 0, fn {name, age,salary}, acc -> acc + salary end)
  end

  # Ejercicio 5
  def incrementar(x), do: x + 1

  def iterate(f, 0, n), do: n
  def iterate(f, i, n), do: iterate(f,i - 1,f.(n))
  #Ejercicio1.iterate(&Ejercicio1.incrementar/1, 1, 3)

  def pow2(x), do: iterate(fn y -> y*2 end, x, 1)
end
