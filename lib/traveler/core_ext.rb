class String
  def unindent
    gsub(/^#{scan(/\A\s*/m).min_by(&:length)}/, "")
  end
end

class Symbol
  def icon
    [{
      ok:       10004,
      error:    10007,
      seeding:  127793,
      wrapping: 127873,
      package:  128230,
    }[self] || 10067].pack('U*')
  end
end
