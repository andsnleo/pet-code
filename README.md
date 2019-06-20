# Pet code
Solução para o desafio de código back-end em Ruby/Rails da Petlove.

## Questões respondidas

### Qual é o custo médio dos animais do tipo cachorro?

```ruby
Animal.where(kind: 'Cachorro').average(:monthly_cost).to_f
```

### Quantos cachorros existem no sistema?

```ruby
Animal.where(kind: 'Cachorro').count
```

### Qual o nome dos donos dos cachorros (Array de nomes)

```ruby
Person.joins(:animals).where(animals: { kind: 'Cachorro' }).pluck(:name)
```

### Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)

```ruby
Person.all.sort_by(&:monthly_cost_with_animals).reverse
```

### Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?

```ruby
Person.all.map { |person| { person.name => format('%.2f', person.monthly_cost_with_animals * 3) }}
```

## Desafio
[Ver desafio completo no Github da Petlove.](https://github.com/petlove/vagas/blob/08d18bdc6a0a9e45d313286c03e87d913fc9dadc/backend-ruby/README.md)

### Cenário

Aplicação para gestão de animais.

- Pessoas tem animais, e animais tem tipos.
- Uma pessoa tem os atributos nome, documento e data de nascimento.
- Um animal tem  os atributos nome, custo mensal e tipo.

### Regras

  - Pessoas podem ter vários animais
  - Pessoas devem ter mais de 18 anos para ter andorinhas
  - Pessoas que tenham nome começando com a letra "A" não podem ter animais do tipo Gato
  - Pessoas que já tiverem custos com animais acima de 1000 não podem ter mais animais
