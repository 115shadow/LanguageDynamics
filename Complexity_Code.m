%% Parameters
a = 1.31; %power
s = 0.53; %status
k = 0.55; %interlinguistic similarity
xinital = 0.84; % x0
yinitial = 0.15; % y0
dt = 0.01; % timestep
tmax = 2;
c = 1;
%initialise vectors
t = 0:dt:tmax; % time vector
Nt = length(t); % number of timesteps
x = zeros(Nt,1);
y = zeros(Nt,1);
b = zeros(Nt,1);
x(1) = xinital;
y(1) = yinitial;

%Main loop
for i = 2:Nt
    %Probabilties
    P_XB = c*k*(1-s)*(1-x(i-1))^a;
    P_YB = c*k*s*(1-y(i-1))^a ;
    P_BY = c*(1-k)*(1-s)*(1-x(i-1))^a;
    P_XY = P_BY;
    P_BX = c*(1-k)*s*(1-y(i-1))^a;
    P_YX = P_BX;

    %Discrete system
    x(i) = x(i-1) + (y(i-1) * P_YX) + (b(i-1) * P_BX) - (x(i-1)*(P_XY + P_XB));
    y(i) = y(i-1) + (x(i-1) * P_XY) + (b(i-1) * P_BY) - (y(i-1)*(P_YX + P_YB));
    b(i) = b(i-1) + (x(i-1) * P_XB) + (y(i-1) * P_YB) - (b(i-1)*(P_BX + P_BY));
end

%Plot
xMax = max(x);
Results = zeros(Nt,3);
Results(1:Nt,1) = x;
Results(1:Nt,2) = y;
Results(1:Nt,3)= b;
Results
plot(t,Results)
axis([0 tmax 0 xMax])
grid on



