defmodule Ejercicios do

    # 1. Fibonacci
    def fib(0), do: 1
    def fib(1), do: 1
    def fib(n) when n >= 2, do: fib(n-1) + fib(n-2)

    def fib2(n), do: fib2(n, 0, 0, 1)
    defp fib2(n, i, f0, f1) when i < n, do: fib2(n, i + 1, f1, f0 + f1)
    defp fib2(n, i, f0, f1), do: f0

    # 2. Potencia
    def pow(_,0), do: 1
    def pow(x,m) when rem(m, 2) == 0, do: pow(x, div(m,2)) * pow(x, div(m,2))
    def pow(x,m) when rem(m, 2) != 0, do: pow(x, div(m,2)) * pow(x, div(m,2)) * x

    def pow1(_, 0), do: 1
    def pow1(x, m) when rem(m, 2) == 0 do
        z =  pow(x, div(m,2))
        z * z
    end
    def pow1(x, m) when rem(m, 2) != 0 do
        z =  pow(x, div(m,2))
        z * z * x
    end

    # 3. Cuenta digitos
    def cuenta_digitos(0), do: 0
    def cuenta_digitos(n), do: 1 + cuenta_digitos(div(n,10))

    def cuenta_digitos1(n), do: cuenta_digitos1(n,0)
    defp cuenta_digitos1(0, acc), do: acc
    defp cuenta_digitos1(n, acc) when n > 0, do: cuenta_digitos1(div(n,10), 1 + acc)

    # 4. Concatenar numeros
    def concatenar(x,y), do: x * pow(10, cuenta_digitos(y)) + y

    # 5. Binario a string
    def binario_str(0), do: "0"
    def binario_str(1), do: "1"
    def binario_str(n) do
      binario_str(div(n, 2)) <> binario_str(rem(n, 2))
    end

    # 6. Rellenar
    def rellenar(s, 0, c), do: s
    def rellenar(s, n, c) do
      l = String.length(s)
      cond do
        l < n -> rellenar(c <> s, n, c)
        l >= n -> s
      end
    end

    def rellenar1(s,n,c), do: rellenar1(s,n,c,s)
    defp rellenar1(s, n, c, acc) do
      l = String.length(acc)
      cond do
        l < n -> rellenar1(s, n, c, c <> acc)
        l >= n -> acc
      end
    end

    # 7. Adivinar número
    def adivina(), do: adivinar(0, 50)
    def adivinar(min, maxi) do
      random = Enum.random(min..maxi)
      r = Integer.to_string(random)
      IO.puts("Es el " <> r <> "?")
      IO.puts("'=': sí, el número es " <> r)
      IO.puts("'M': no, mi número es mayor")
      IO.puts("'m': no, mi número es menor")
      option = IO.gets("Introduce tu opción: ")
      if min < maxi do
        case option do
          "=\n" -> IO.puts("¡Tu número es " <> r <> "!")
          "m\n" -> adivinar(min, random - 1)
          "M\n" -> adivinar(random + 1, maxi)
        end
      else
        IO.puts("¡Me has engañado!")
      end
    end

    # 8. drop
    def drop(xs, 0), do: xs
    def drop([x | xs], n) when n > 0 do
      drop(xs, n - 1)
    end

    # 9. keyfind
    def keyfind([], _), do: nil
    def keyfind([{x,y} | xs], k) do
      cond do
        x == k -> y
        x != k -> keyfind(xs, k)
      end
    end

    def keytake([{x,y} | xs], k) do
      elem = {k, keyfind([{x,y} | xs], k)}
      {elem, Enum.filter([{x,y} | xs], fn{field, value} -> field != k end)}
    end

    def keyfind2([], _, d), do: d
    def keyfind2([{x,y} | xs], k, d) do
      cond do
        x == k -> y
        x != k -> keyfind2(xs, k, d)
      end
    end

    # 10. Ordenada
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

    # 11. insertar ordenadamente
    def insertar_ord([], x), do: [x]
    def insertar_ord([y | ys], x) do
      cond do
        x <= y -> [x, y | ys]
        x > y -> [y | insertar_ord(ys, x)]
      end
    end

    # PENDIENTE
    def insert_ord([]), do: []
    def insert_ord([x | xs]) do
      lista_ord = insert_ord(xs)
      insertar_ord(lista_ord, x)
    end

    # 12. Quicksort
    def particion(xs, p), do: particion(xs, p, [],[])
    defp particion([], _, small, bigger), do: {small, bigger}
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

    # 13. Mergesort
    def repartir(xs), do: repartir(xs, [], [])
    def repartir([], impares, pares), do: {impares, pares}
    def repartir([x], impares, pares), do: {[x | impares], pares}
    def repartir([x, y | xs], impares, pares) do
      repartir(xs, [x | impares], [y | pares])
    end

    def mezclar(xs, ys), do: mezclar(xs, ys, [])
    def mezclar([], ys, acc), do: Enum.reverse(acc) ++ ys
    def mezclar(xs, [], acc), do: Enum.reverse(acc) ++ xs
    def mezclar([x|xs], [y |ys], acc) do
      if x < y do
        mezclar(xs, [y | ys], [x | acc])
      else
        mezclar([x | xs], ys, [y | acc])
      end
    end

    def merge([]), do: []
    def merge([x]), do: [x]
    def merge(xs) do
      {impares, pares} = repartir(xs)
      mezclar(merge(impares), merge(pares))
    end

    # 14. all? y any?
    def all?([], _), do: true
    def all?([x | xs], f) do
      if f.(x), do: all?(xs, f), else: false
    end

    def any?([], _), do: false
    def any?([x | xs], f) do
      if not f.(x), do: any?(xs, f), else: true
    end

    # 15 Ordenada -- PENDIENTE
    def ordered([]), do: true
    def ordered([x]), do: true
    def ordered([x,y | xs]), do: all?([x, y | xs], fn [x,y] -> x <= y end)

    # 16. Count Devuelve el numero de veces que f se evalua a true
    def count([], _), do: 0
    def count([x | xs], f) do
      if f.(x) do
        1 + count(xs, f)
      else
        count(xs, f)
      end
    end

    def count2([x | xs], f) do
      Enum.reduce([x | xs], 0,fn x, acc ->
        if f.(x) do
           acc+1
        else
            acc
        end
      end)
    end

    def count3([x | xs], f) do
      Enum.reduce([x | xs], [] ,fn x, acc ->
        if f.(x) do
           [x | acc]
        else
            acc
        end
      end)
    end

    # Ejercicios.count([1,2,3,4], fn x -> x >= 1 end)
    # Ejercicios.count([1,2,3,4], fn x -> rem(x,2) == 1 end)
    # Ejercicios.count([{1,2},{4,3},{7,5}], fn {x,y} -> x >= y end)
    # Ejercicios.count(["hola", "adios", "high"], fn str -> String.starts_with?(str,"h") end)

    # 17. Filter usando flat map
    def filter1(xs, f) do
       Enum.flat_map(xs, fn x ->
        if f.(x), do: [x], else: []
      end)
    end

    # 18. Reduce while
    def reduce_while([], acc, _), do: acc
    def reduce_while([x | xs], acc, f) do
      case f.(x, acc) do
        {:cont, v} -> reduce_while(xs, v, f)
        {:halt, v} -> v
      end
    end

    def all_reduce(xs, f) do
      reduce_while(xs, [], fn x, _ ->
        if f.(x), do: {:cont, true}, else: {:halt, false}
      end)
    end

    # 19. Frecuencias
    def frequencies(xs) do
      xs_p = Enum.map(xs, fn x -> {x, 1} end)
      Enum.reduce(xs_p, %{}, fn {k, v}, acc ->
        apariciones = Map.get(acc, k, 1)
        Map.put(acc, k, apariciones + 1)
      end)
    end

    # 20. take while
    def take_while(xs, f), do: take_while(xs, f, [])
    def take_while([], f, acc), do: acc
    def take_while([x |xs], f, acc) do
      if f.(x), do: take_while(xs, f, [x | acc]), else: acc
    end

    def take_while2(xs, f) do
      reduce_while(xs, [], fn x, acc ->
        if f.(x), do: {:cont, [x | acc]}, else: {:halt, acc}
      end)
    end

    def drop_while([], f), do: []
    def drop_while([x | xs], f) do
      if f.(x), do: drop_while(xs, f), else: [x | xs]
    end

    def drop_while2([], _), do: []
    def drop_while2(xs, f) do
      Enum.reduce_while(xs, xs, fn x, acc ->
        if f.(x) do
          {:cont, tl(acc)}
        else
          {:halt, acc}
        end
      end)
    end

    def split_while(xs, f), do: {take_while(xs,f), drop_while(xs, f)}
end
