function [rocheRadius] = calculateRocheRadius(Md,Ma)
% calculateRocheRadius(Md,Ma)
% Roche radius following Eggleton 1983.
% Roche radius as seen by star 1, e.g. donor star.
% q = Md/Ma
q = Md/Ma;
rocheRadius = 0.49./(0.6+(log(1+q.^(1.0./3))./(q.^(2.0./3))));

end