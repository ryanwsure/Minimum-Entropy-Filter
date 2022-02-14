

% Minimun Entropy Signal Detector
% Input signal length should be limited within 50000 for acceptable performance.
% Input signal should be formatted as 1x (Length) vector.

function result= minentropy(InputSignal, WindowLength)

DataLength=size(InputSignal,2);
ValueStat=unique(InputSignal); % 原序列中所有值的不重复集合，并排序

% Easier PSD
[PSD,~]=ksdensity(InputSignal,ValueStat);
PSD=PSD/sum(PSD);

% Accquiring P(xi)
[~, Index] = ismember(InputSignal, ValueStat);
PSDSequence=PSD(Index);

% Minimum Entropy Filtering
TempMat=zeros(WindowLength,DataLength+WindowLength-1);

for i=1:WindowLength
    TempMat(i,i:(DataLength+i-1))=PSDSequence;
end

CalMat=TempMat(:,WindowLength:DataLength);
LnCalMat=log(CalMat);

result=-sum(CalMat.*LnCalMat);


end