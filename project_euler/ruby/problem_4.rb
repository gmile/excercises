# number-palindrome
#

9.downto(1) do |x|
  9.downto(1) do |y|
    9.downto(1) do |z|
      p = 11 * ( 9091*x + 910*y + 100*z )

      p_s = p.to_s

      if p_s[0..2] == p_s[5] << p_s[4] << p_s[3] 
        abort p.to_s
      end
    end
  end
end
