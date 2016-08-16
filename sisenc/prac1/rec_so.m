% funcio equivalent a wavrecord.m de Matlab
% x=rec_so(N,Fm), x és vector mostres, N nombre de mostres, Fm és freqüència de mostreig
function x=rec_so(N, Fm)
    if nargin==1, Fm=48e3, elseif (nargin !=2), print_usage (), end
    file=[tmpnam(), '.wav'];% genera un arxiu en el directori temporal
    tf=N/Fm; % durada del senyal
    input ('Please hit ENTER and speak afterwards!\n', 1);
    %cmd = sprintf ('rec -c1 -r%d %s trim 0 %d',Fm,file,tf), system (cmd);
    system(['rec -c1 -r ',num2str(Fm),' ',file,' trim 0 ',num2str(tf)])
    x=wavread(file);
    system(['rm ',file]); % suprimeix l'arxiu temporal
end
