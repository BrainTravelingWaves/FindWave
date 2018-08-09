name={'V1l','V1r','V2l','V2r'};
Nj=length(name);
mm=[];
for j=1:Nj
    s=name{j};
    if s(2)=='1'
        N=3;
    else
        N=8;
    end;
    for i=1:N
        load(strcat('seeg',name{j},num2str(i),'.mat'));
        m=max(max(seeg));
        m=squeeze(m);
        mm=vertcat(mm,m);
    end;
end;
mm=sort(mm*0.000000001);