fizzbuzz = fn
  0, 0, _ -> "FizzBuzz" 
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

IO.inspect(fizzbuzz.(0, 0, 1))
IO.inspect(fizzbuzz.(1, 0, 2))
IO.inspect(fizzbuzz.(0, 1, 3))
IO.inspect(fizzbuzz.(1, 1, 4))
