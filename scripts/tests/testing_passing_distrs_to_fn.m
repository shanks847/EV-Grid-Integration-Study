function [res] = testing_passing_distrs_to_fn(dist)
%TESTING_PASSING_DISTRS_TO_FN Testing how to pass a distribution to a func

res = 5*round(dist.random()/5);

end