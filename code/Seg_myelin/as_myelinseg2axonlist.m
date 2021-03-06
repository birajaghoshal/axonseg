function axonlist=as_myelinseg2axonlist(seg,Pixelsize)
% list=as_myelinseg_bw2list(seg,Pixelsize)
emptyseg = find(~sum(sum(seg,1),2)); if ~isempty(emptyseg), seg(:,:,emptyseg)=[]; end
stats=as_stats(seg,Pixelsize);
if isempty(seg)
    seg=zeros(max(2,size(seg,1)),max(2,size(seg,2)));
end
sfields=as_stats_fields;

for iaxon=size(seg,3):-1:1
    [axonlist(iaxon).data(:,1), axonlist(iaxon).data(:,2)]=find(seg(:,:,iaxon));
    axonlist(iaxon).data = single(axonlist(iaxon).data);
    tmp=regionprops(seg(:,:,iaxon),'Centroid');
    if isempty(tmp), axonlist(iaxon).Centroid=[];
    else
        axonlist(iaxon).Centroid=tmp(1).Centroid([2 1]);
    end
    for istat=1:length(sfields)
        tmp=stats.(sfields{istat});
        axonlist(iaxon).(sfields{istat})=tmp(iaxon);
    end
end
