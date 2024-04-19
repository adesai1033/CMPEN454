walk = 'DataSets/walk';
trees = 'DataSets/trees';
movecam = 'DataSets/movecam';
getout = 'DataSets/getout';
getin = 'DataSets/getin';
AShipDeck = 'DataSets/AShipDeck';
APossum = 'DataSets/APossum';
ADeerBackyard = 'DataSets/ADeerBackyard';
AAnts = 'DataSets/AAnts';

dirstring = walk;
maxframenum = length(dir(fullfile(dirstring, 'f*.jpg')));

abs_diff_threshold = 45;
alpha_parameter = 0.15;
gamma_parameter = 5;

proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)