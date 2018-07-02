## Ex. 1

* no need to compute distortion twice; for efficiency, initialize it before the cycle and
compute it only once
* `epsilon` increment should be different for every direction, depending on data covariance
(instead of having the same value in x,y directions)
* for compactness and efficiency, `updateClusters()`` should return *distances* too, besides assignments Z

## Ex. 2

* change
```
  for i=idx(1):idx(end)
```
to
```
  for i=idx
```
otherwise wrong extra indices would be considered!

* check definition of delta(regression error) = error before - (error after, computed as a sum)

## Ex. 4

* Viterbi probabilities are different than forward probabilities: Viterbi uses max instead of sum; it is faster and yields a smaller probability: 4e-05 instead of 9e-04 (forward)
* forward is only useful for isolated data vectors (because it makes a total sum)
* for sequences of various, continuous symbols, as in speech, Viterbi is necessary: it can "segment" `a` then `b`, whereas the forward algorithm would compute a "dumb" sum within the whole `ab` sequence

## Ex. 5

* in `estimateObsProb.m`, change
```
  for t = occurrences{alphabet(k)}(1):occurrences{alphabet(k)}(end)
```
to
```
  for t = occurrences{alphabet(k)}
```
otherwise wrong extra indices would be considered! (not in this particular case, though)
