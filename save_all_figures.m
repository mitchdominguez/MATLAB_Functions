mkdir Figures
FolderName = 'Figures\';
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
n = length(FigList);
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = get(FigHandle, 'Name');
  saveas(FigHandle, fullfile([FolderName 'Figure' num2str(n-iFig+1) '.png']));
end