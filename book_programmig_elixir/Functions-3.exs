fizzbuzz = fn
  0, 0, _ -> "FizzBuzz" 
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

fizzbuzz_full = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

IO.inspect(fizzbuzz_full.(10))
IO.inspect(fizzbuzz_full.(11))
IO.inspect(fizzbuzz_full.(12))
IO.inspect(fizzbuzz_full.(13))
IO.inspect(fizzbuzz_full.(14))
IO.inspect(fizzbuzz_full.(15))
IO.inspect(fizzbuzz_full.(16))
