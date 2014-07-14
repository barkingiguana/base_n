require "base_n/version"

module BaseN
  class Number < Struct.new(:representation, :base)
    def to_s
      representation
    end

    def to_i
      Encoder.new(base).decode self
    end

    def rebase new_base
      Encoder.new(new_base).encode to_i
    end
  end

  class Encoder
    PRIMITIVES = ((0..9).collect { |i| i.to_s } + ('A'..'Z').to_a + ('a'..'z').to_a + %w(- _)).map(&:freeze).freeze

    attr_accessor :base

    def initialize base
      self.base = base
      raise "I only support bases 2 and above" if base < 2
      raise "I only support up to base #{primitives.size}" if base > primitives.size
    end

    def case_sensitive?
      base > 36
    end

    def primitives
      PRIMITIVES[0, base]
    end

    def decode subject
      r = subject.representation
      r.upcase! unless Encoder.new(subject.base).case_sensitive?
      s = r.reverse.split('')

      total = 0
      s.each_with_index do |char, index|
        if ord = primitives.index(char)
          total += ord * (base ** index)
        else
          raise ArgumentError, "#{subject} has #{char} which is not valid"
        end
      end
      total
    end

    def encode subject
      subject = Number.new subject.to_s, 10 unless subject.kind_of? BaseN::Number
      return subject if subject.base == base

      i = Encoder.new(subject.base).decode(subject)

      s = ''

      while i > 0
        s << primitives[i.modulo(base)]
        i /= base
      end
      s = '0' if s == ''
      Number.new s.reverse, base
    end
  end
end

if __FILE__ == $0
  include BaseN
  2.upto Encoder::PRIMITIVES.size do |n|
    puts "Base 10 | Base #{n} converted"
    e = Encoder.new n
    0.upto Encoder::PRIMITIVES.size + 1 do |n|
      s = e.encode(n).to_s
      puts "%7s | %s" % [ n, s ]
    end
    puts "-" * 80
  end
end
