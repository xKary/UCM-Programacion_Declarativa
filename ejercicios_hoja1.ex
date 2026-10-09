defmodule Ejercicios do
    def ordenada?([]), do: true
    def ordenada?([_ | []]), do: true
    def ordenada?([x | xs]) do
      y = hd(xs)
      cond do
        x <= y -> ordenada?(xs)
        x > y -> false
      end
    end

    def ordenada2?([_]), do: true
    def ordenada2?([x , y | _]) when x > y, do: false
    def ordenada2?([x , y | xs]) when x <= y do
      ordenada2?([y | xs])
    end

    def particion(xs, p), do: particion(xs, p, [],[])
    defp particion([], p, small, bigger), do: {small, bigger}
    defp particion([x | xs], p, small, bigger) do
      cond do
        x <= p -> particion(xs, p, [x | small], bigger)
        x > p -> particion(xs, p, small, [x | bigger])
      end
    end

    def qsort([]), do: []
    def qsort([x]), do: [x]
    def qsort([x | xs]) do
      {small, bigger} = particion(xs, x)
      qsort(small) ++ [x] ++ qsort(bigger)
    end

    def particion2?([], _), do: {[],[]}
    def particion2?([x | xs], p) do
      [menores, mayores] = particion(xs, p)
      if x <= p do
        {[x | menores], mayores}
      else
        {menores, [x | mayores]}
      end
    end

end
