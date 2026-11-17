void main(){
    var nombres = Arrays.asList("Luis", "Ana Sofia", "María", "Pedro", "Consuelo");
    var s = nombres.stream()
            .map(String::length)
            .filter(x -> {
                System.out.println("Imprimiento si " + x + " es mayor a 4");
                return x >= 4;
            });
    System.out.println(s.count());
}
