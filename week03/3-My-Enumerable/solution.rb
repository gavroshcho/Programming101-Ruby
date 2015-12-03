# Implementation of our own Enumerable class
module MyEnumerable
  def map
    Array.new.tap do |arr|
      each do |element|
        value = yield element
        arr << value
      end
    end
  end

  def filter
    Array.new.tap do |arr|
      each do |element|
        arr << element if (yield element) == true
      end
    end
  end

  def reject
    Array.new.tap do |arr|
      each do |element|
        arr << element if (yield element) == false
      end
    end
  end

  def reduce(initial = nil)
    each do |element|
      if initial.nil?
        initial = element
      else
        initial = yield element, initial
      end
    end
    initial
  end

  def any?
    each do |element|
      if (yield element) == false
        false
      else
        return true
      end
    end
  end

  def all?
    each do |element|
      if (yield element) == false
        return false
      else
        true
      end
    end
  end

  def include?(element)
    each do |item|
      if item == element
        return true
      else
        false
      end
    end
  end

  def count(element = nil)
    counter = 0
    each do |item|
      counter += 1 if element.nil?
      counter += 1 if item == element
    end
    counter
  end

  def size
    counter = 0
    each do
      counter += 1
    end
    counter
  end

  def min
    reduce do |element, accumulator|
      accumulator > element ? element : accumulator
    end
  end

  def min_by
    reduce do |element, accumulator|
      (yield accumulator) > element.size ? element : accumulator
    end
  end

  def max
    reduce do |element, accumulator|
      accumulator < element ? element : accumulator
    end
  end

  def max_by
    reduce do |element, accumulator|
      (yield accumulator) < element.size ? element : accumulator
    end
  end

  def take(n)
    counter = 0
    Array.new.tap do |arr|
      each do |element|
        return Array.new if n == 0
        arr << element
        counter += 1
        break if counter == n
      end
    end
  end

  def take_while
    Array.new.tap do |arr|
      each do |element|
        if (yield element) == true
          arr << element
        else
          break
        end
      end
      return [] if arr.size == 0
    end
  end

  def drop(n)
    counter = 0
    Array.new.tap do |arr|
      each do |element|
        arr << element if counter >= n
        counter += 1
      end
    end
  end

  def drop_while
    counter = 0
    each do |element|
      counter += 1 if (yield element) == true
      return drop(counter) if (yield element) == false
    end
  end
end
