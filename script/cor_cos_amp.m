function [ Amp ]= cor_cos_amp(dist,PARAM)
%Load amp
Amp=zeros(size(dist,2),PARAM.N_step);
md=(dist<PARAM.max_dist);
l_wave=PARAM.v_wave/PARAM.w_frequ;
for i=1:PARAM.N_step 
    Amp(:,i)=(cos(2*pi*dist/l_wave-2*pi*i*PARAM.w_frequ/PARAM.SR)).*md; 
end
Amp=Amp*PARAM.ca; %0.000336725; % A (250 nA/mm2) for ICBN152
end