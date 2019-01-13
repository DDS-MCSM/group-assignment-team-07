def edit_domain(domain) :
  # letters = 'abcdefghijklmnopqrstuvwxyz01'
  splitted_domain = domain.split('.')
  word = splitted_domain[0]

  #letters = 'a4iIl0o1uvbdpqs5|'
  letters = ''
  splits = [(word[:i], word[i:]) for i in range(len(word) + 1)]
  deletes = [L + R[1:] for L, R in splits if R]
  transposes = [L + R[1] + R[0] + R[2:] for L, R in splits if len(R)>1]
  replaces = [L + c + R[1:] for L, R in splits if R for c in letters]
  inserts = [L + c + R for L, R in splits for c in letters]
  # return set(deletes + transposes + replaces + inserts)
  return [word + "." + splitted_domain[1] for word in transposes + replaces]
