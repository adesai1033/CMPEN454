walk = 'DataSets/walk';
trees = 'DataSets/trees';
movecam = 'DataSets/movecam';
getout = 'DataSets/getout';
getin = 'DataSets/getin';
AShipDeck = 'DataSets/AShipDeck';
APossum = 'DataSets/APossum';
ADeerBackyard = 'DataSets/ADeerBackyard';
AAnts = 'DataSets/AAnts';
threshold = 30;
alpha = 0.2;

testingDatas = {walk, trees, movecam, getout, getin, AShipDeck, APossum, ADeerBackyard, AAnts};
for i = 1:length(testingDatas)
    smpl_fd_out = smpl_fd(testingDatas{i}, threshold);
end