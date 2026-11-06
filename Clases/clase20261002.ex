defmodule Ejemplo do
    def len([]), do: 0
    def len(xs), do: 1 + len(tl(xs))

    def len1([]), do: 0
    def len1([_ | xs]), do: 1 + len(xs)

    def len2(xs) do
      case xs do
        [] -> 0
        [_|ys] -> 1 + len2(ys)
      end
    end

    def suma_componentes({x,y}) when is_number(x) and is_number(y), do: x + y
    def suma_componentes(_), do: :no_se_que_es_eso


    def fib(0), do: 1
    def fib(1), do: 1
    def fib(n) when n >= 2, do: fib(n-1) + fib(n-2)

    def fib2(n), do: fib2(n, 0, 0, 1)
    defp fib2(n, i, f0, f1) when i < n, do: fib2(n, i + 1, f1, f0 + f1)
    defp fib2(n, i, f0, f1), do: f0

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

    def cuenta_digitos(0), do: 0
    def cuenta_digitos(n), do: 1 + cuenta_digitos(div(n,10))

    def cuenta_digitos1(n), do: cuenta_digitos1(n,0)
    defp cuenta_digitos1(0, acc), do: acc
    defp cuenta_digitos1(n, acc) when n > 0, do: cuenta_digitos1(div(n,10), 1 + acc)

    def concatenar(x,y), do: x

    def binario_str(n), do: n

    def rellenar_con(s,n,c) when length(c)
    def rellenar_con(s,n,c) when length(c) < n, do: s <> c

end
