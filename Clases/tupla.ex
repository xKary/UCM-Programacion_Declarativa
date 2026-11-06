#iex -S mix -- compilar proyecto, desde la carpeta del proyecto
defmodule ConTuplas do
    def convertir_a_cadena({d,m,a}) do
      "#{d}/#{m}/#{a}"
    end

    def siguiente_año({29,02,a}) do
      {01,03,a + 1}
    end

    def siguiente_año({d,m,a}) do
      {d,m,a + 1}
    end
end

defmodule ConDiccionarios do
def convertir_a_cadena(%{dia: d,mes: m, año: a}) do
      "#{d}/#{m}/#{a}"
    end

    def siguiente_año(%{dia: 29,mes: 02, año: a}) do
      %{dia: 01,mes: 03, año: a}
    end

    def siguiente_año(%{año: a} = f) do
      %{f | año: a + 1}
    end
end

defmodule Fecha do
    defstruct [:dia, :mes, :año]
end
#%Fecha{dia: 25, mes: 12, año: 2002}

defmodule ConStruct do
    def convertir_a_cadena(%Fecha{} = f) do
      "#{f.dia}/#{f.mes}/#{f.año}"
    end

    def siguiente_año(%Fecha{dia: 29,mes: 02, año: a}) do
      %Fecha{dia: 01,mes: 03, año: a}
    end

    def siguiente_año(%Fecha{año: a} = f) do
      %Fecha{f | año: a + 1}
    end
end

defmodule Rectangulo do
    defstruct [:ancho, :alto]
end

defmodule Circulo do
    defstruct [:radio]
end

defmodule Figuras do
    def area(%Rectangulo{ancho: a, alto: l}) do
      a*l
    end

    def area(%Circulo{radio: r}) do
      3.14159 * r * r
    end
end
