# elixir "file.es"
# iex
# c "file.ex"
defmodule OrdenSuperior do
    import Kernel, except: [max: 2]
    def mayor_que(x,y), do: x >= y

    def mayor_suma_componentes({x,y},{u,v}) do
      x + y >= u + v
    end

    def max(xs, f \\ &mayor_que/2)
    #def max(xs, f \\ &>=/2)
    def max([x],_), do: x
    def max(([x | xs]),f) do
        max_cola = max(xs, f)
        if f.(x,max_cola) do
          x
        else
          max_cola
        end
    end

    # Funciones anonimas
    # OrdenSuperior.max(["alaa", "perz","prado"], fn x,y -> x >= y end)
    # OrdenSuperior.max(["alaa", "perz","prado"], fn x,y -> String.length(x) >= String.length(y) end)
    # f = &(Enum.take(&1,2))

    # TOP 5 funciones de orden superior
    # ********** MAP/2 **********************
    # Enum.map([1,2,3,4], &(&1 * 2))
    # require Integer
    # Enum.map([1,2,3,4], &Integer.is_even/1)
    # Enum.map(["hola", "adios", "hasta luego"], &String.last/1)

    # ********** FILTER/2 **********************
    # Enum.filter([1,2,3,4], &Integer.is_even/1)
    # Enum.filter([1,2,3,4], &Integer.is_odd/1)
    # Enum.filter([1,2,3,4], fn x -> x >= 5 end)

    # Enum.reject([1,2,3,4], fn x -> x >= 2 end)
    # Enum.split_with([1,2,3,4], fn x -> x >= 2 end)

    # ********** REDUCE/3 **********************
    # Enum.reduce([1,2,3,4], 0, &(&1 + &2))
    # Enum.reduce([1,2,3,4], 0, fn _, x -> x + 1 end) // longitud de la lista
    # Enum.reduce([:a,:b,:c],[], fn x, ac -> [x|ac] end) // reversa

    def count1(xs,f) do
      Enum.reduce(xs, 0, fn x, acc ->
        if f.(x), do: acc + 1, else: acc
      end)
    end

    def filter1(xs, f) do
      Enum.reverse(
        Enum.reduce(xs, [], fn x,acc ->
          if f.(x), do: [x | acc], else: acc
        end)
      )
    end

    # ********** FLAT_MAP/2 **********************
    # Enum.flat_map([1,2,3], fn x -> [x, x + 1, x + 2] end)

    def filter2(xs, f) do
      Enum.flat_map(xs, fn x ->
        if f.(x), do: [x], else: []
      end)
    end
    # Ejercicios.filter1([1,2,3,4], &Integer.is_odd/1

    # ********** ZIP_WITH/3 **********************
    # Enum.zip_with([2,4,6,8], [1,3,5,7], &(&1 + &2))
end
