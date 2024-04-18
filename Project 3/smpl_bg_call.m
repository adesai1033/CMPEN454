
walk = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/walk';
trees = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/trees';
movecam = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/movecam';
getout = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/getout';
getin = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/getin';
AShipDeck = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/AShipDeck';
APossum = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/APossum';
ADeerBackyard = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/ADeerBackyard';
AAnts = '/Users/abhidesai/Desktop/C/Education/School/Semester 6/CMPEN 454/Project 3/DataSets/AAnts';
threshold = 30;
alpha = 0.2;

testingDatas = {walk, trees, movecam, getout, getin, AShipDeck, APossum, ADeerBackyard, AAnts};
for i = 1:length(testingDatas)
    smpl_bg_out = smpl_bg(testingDatas{i}, threshold);
end