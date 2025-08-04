function [result] = MPCA_LKF_Solver(params)
% MPCA_LKF_SOLVER MPCA-LKF method solver
% 
% Input:
%   params - System parameter structure
% 
% Output:
%   result - Solver result structure

%% Parameter extraction
A_1 = params.A(:,:,1);
A_2 = params.A(:,:,2);
B_1 = params.B(:,:,1);
B_2 = params.B(:,:,2);
C_1 = params.C(:,:,1);
C_2 = params.C(:,:,2);
K1 = params.K1;
K2 = params.K2;

% MPCA-LKF requires more complex parameter structure
a111 = params.a111;
a112 = params.a112;
a121 = params.a121;
a122 = params.a122;
a211 = params.a211;
a212 = params.a212;
a221 = params.a221;
a222 = params.a222;

b111 = params.b111;
b112 = params.b112;
b121 = params.b121;
b122 = params.b122;
b211 = params.b211;
b212 = params.b212;
b221 = params.b221;
b222 = params.b222;

n = params.n;
h_1 = params.h_1;
h_2 = params.h_2;
h_12 = h_2 - h_1;

h_k = h_1;
h_1k = h_k - h_1 + 1;
h_2k = h_2 - h_k + 1;

alpha_1 = params.alpha_1;
alpha_2 = params.alpha_2;
mu_1 = params.mu_1;
mu_2 = params.mu_2;
pho_1 = params.pho_1;
pho_2 = params.pho_2;

v1=[zeros(n,(1-1)*n),eye(n),zeros(n,(20-1)*n)];
v2=[zeros(n,(2-1)*n),eye(n),zeros(n,(20-2)*n)];
v3=[zeros(n,(3-1)*n),eye(n),zeros(n,(20-3)*n)];
v4=[zeros(n,(4-1)*n),eye(n),zeros(n,(20-4)*n)];
v5=[zeros(n,(5-1)*n),eye(n),zeros(n,(20-5)*n)];
v6=[zeros(n,(6-1)*n),eye(n),zeros(n,(20-6)*n)];
v7=[zeros(n,(7-1)*n),eye(n),zeros(n,(20-7)*n)];
v8=[zeros(n,(8-1)*n),eye(n),zeros(n,(20-8)*n)];
v9=[zeros(n,(9-1)*n),eye(n),zeros(n,(20-9)*n)];
v10=[zeros(n,(10-1)*n),eye(n),zeros(n,(20-10)*n)];
v11=[zeros(n,(11-1)*n),eye(n),zeros(n,(20-11)*n)];
v12=[zeros(n,(12-1)*n),eye(n),zeros(n,(20-12)*n)];
v13=[zeros(n,(13-1)*n),eye(n),zeros(n,(20-13)*n)];
v14=[zeros(n,(14-1)*n),eye(n),zeros(n,(20-14)*n)];
v15=[zeros(n,(15-1)*n),eye(n),zeros(n,(20-15)*n)];
v16=[zeros(n,(16-1)*n),eye(n),zeros(n,(20-16)*n)];
v17=[zeros(n,(17-1)*n),eye(n),zeros(n,(20-17)*n)];
v18=[zeros(n,(18-1)*n),eye(n),zeros(n,(20-18)*n)];
v19=[zeros(n,(19-1)*n),eye(n),zeros(n,(20-19)*n)];
v20=[zeros(n,(20-1)*n),eye(n),zeros(n,(20-20)*n)];

e_1=A_1*v1+B_1*v5+C_1*v7;
e_2=A_2*v1+B_2*v5+C_2*v7;

C1=[v9;v1-v2;v13;h_1*v1-v9];
C2=[v10;v2-v4;v14;h_12*v1-v10];
C3=[v1-v2;v1+v2-2*v9;v1-v2+6*v9-12*v10];
C4=[v9;v1-v2];
C5=[v2-v3;v2+v3-2*h_1k*v11;v2-v3+6*h_1k*v11-12*v15];
C6=[v3-v4;v3+v4-2*h_2k*v12;v3-v4+6*h_2k*v12-12*v16];
C7=[v11-v2;v2-v3];
C8=[v12-v3;v3-v4];

pi1=[C5' C6'];
pi2=[C7' C8'];

Pi11=[v1;e_1-v1]; %p=1
Pi12=[v1;e_2-v1]; %p=2
Pi2=[v2;v19];
Pi3=[v4;v20];

%%
  P111=sdpvar(n,n,'symmetric');
  P112=sdpvar(n,n,'symmetric');
  P121=sdpvar(n,n,'symmetric');
  P122=sdpvar(n,n,'symmetric');
  P211=sdpvar(n,n,'symmetric');
  P212=sdpvar(n,n,'symmetric');
  P221=sdpvar(n,n,'symmetric');
  P222=sdpvar(n,n,'symmetric');

  Q1_1=sdpvar(2*n,4*n) ;
  Q1_2=sdpvar(2*n,4*n) ;
  Q2_1=sdpvar(2*n,4*n) ;
  Q2_2=sdpvar(2*n,4*n) ;
  
  Q1_11=sdpvar(2*n,2*n) ;
  Q1_12=sdpvar(2*n,2*n) ;
  Q1_21=sdpvar(2*n,2*n) ;
  Q1_22=sdpvar(2*n,2*n) ;  
  Q2_11=sdpvar(2*n,2*n) ;
  Q2_12=sdpvar(2*n,2*n) ;
  Q2_21=sdpvar(2*n,2*n) ;
  Q2_22=sdpvar(2*n,2*n) ;
 
 W11=sdpvar(2*n,2*n,'symmetric');
 W12=sdpvar(2*n,2*n,'symmetric');
 W21=sdpvar(2*n,2*n,'symmetric');
 W22=sdpvar(2*n,2*n,'symmetric');
 
 Z11=sdpvar(n,n,'symmetric');
 Z12=sdpvar(n,n,'symmetric'); 
 Z21=sdpvar(n,n,'symmetric');
 Z22=sdpvar(n,n,'symmetric');
 
 R11=sdpvar(2*n,2*n,'symmetric');
 R12=sdpvar(2*n,2*n,'symmetric');
 R21=sdpvar(2*n,2*n,'symmetric');
 R22=sdpvar(2*n,2*n,'symmetric');
 
 T11=sdpvar(n,n,'full');%p=1,i=1...5
 T12=sdpvar(n,n,'full');
 T13=sdpvar(n,n,'full');
 T14=sdpvar(n,n,'full');
 T15=sdpvar(n,n,'full');
 
 T21=sdpvar(n,n,'full'); %p=2,i=1...5
 T22=sdpvar(n,n,'full'); 
 T23=sdpvar(n,n,'full'); 
 T24=sdpvar(n,n,'full'); 
 T25=sdpvar(n,n,'full'); 
 
 Y1=sdpvar(3*n,3*n,'full');
 Y2=sdpvar(3*n,3*n,'full');
 S1=sdpvar(2*n,2*n,'full');
 S2=sdpvar(2*n,2*n,'full');
 
 D=sdpvar(n,1) ; 
 M11=diag(D);  %p=1,i=1...4
 M12=diag(D);
 M13=diag(D);
 M14=diag(D);
 
 M21=diag(D); %p=2,i=1...4
 M22=diag(D); 
 M23=diag(D);
 M24=diag(D);
 
 D11=diag(D); %p=1,i=1,2,3
 D12=diag(D);
 D13=diag(D);
 
 D21=diag(D); %p=2,i=1,2,3
 D22=diag(D);
 D23=diag(D);
 
 N11=sdpvar(n,n,'full'); 
 N12=sdpvar(n,n,'full'); 
 N21=sdpvar(n,n,'full'); 
 N22=sdpvar(n,n,'full'); 
 
 F1=sdpvar(20*n,n);
 F2=sdpvar(20*n,n);
 
Z_11=[Z11 zeros(n,2*n);zeros(n,n) 3*Z11 zeros(n,n);zeros(n,2*n) 5*Z11];%p=1,i=1
Z_21=[Z21 zeros(n,2*n);zeros(n,n) 3*Z21 zeros(n,n);zeros(n,2*n) 5*Z21];%p=2,i=1

Z_12=[Z12 zeros(n,2*n);zeros(n,n) 3*Z12 zeros(n,n);zeros(n,2*n) 5*Z12];%p=1,i=2
Z_22=[Z22 zeros(n,2*n);zeros(n,n) 3*Z22 zeros(n,n);zeros(n,2*n) 5*Z22];%p=2,i=2

R_113=R11+[zeros(n,n)  T13;T13'  T13];%i=3,p=1 R1
R_123=R21+[zeros(n,n)  T23;T23'  T23];%i=3,p=2 R1

R_214=R12+[zeros(n,n)  T14;T14'  T14];%i=4,p=1 R2
R_215=R12+[zeros(n,n)  T15;T15'  T15];%i=5,p=1 R2

R_224=R22+[zeros(n,n)  T24;T24'  T24];%i=4,p=2 R2
R_225=R22+[zeros(n,n)  T25;T25'  T25];%i=5,p=2 R2

V111=v1'*(P111+h_1*Z11+h_12*Z12)*v1; %p=1
V112=v1'*(P112+h_1*Z11+h_12*Z12)*v1;
V121=v1'*(P121+h_1*Z11+h_12*Z12)*v1;
V122=v1'*(P122+h_1*Z11+h_12*Z12)*v1;

V211=v1'*(P211+h_1*Z21+h_12*Z22)*v1; %p=2
V212=v1'*(P212+h_1*Z21+h_12*Z22)*v1;
V221=v1'*(P221+h_1*Z21+h_12*Z22)*v1;
V222=v1'*(P222+h_1*Z21+h_12*Z22)*v1;


T1=[T11 zeros(n,2*n);zeros(n,n) (T12-T11) zeros(n,n);zeros(n,2*n) -T12];
T2=[T21 zeros(n,2*n);zeros(n,n) (T22-T21) zeros(n,n);zeros(n,2*n) -T22];

V21=[v1' v2' v4']*T1*[v1' v2' v4']'-(v1'*Z11*v9+v1'*Z12*v10)-(v1'*Z11*v9+v1'*Z12*v10)';%p=1
V22=[v1' v2' v4']*T2*[v1' v2' v4']'-(v1'*Z21*v9+v1'*Z22*v10)-(v1'*Z21*v9+v1'*Z22*v10)';%p=2

Z_111=[Z11 -T11;-T11' -T11 ];%p=1, T1, Z1
Z_211=[Z21 -T21;-T21' -T21 ];%p=2, T1, Z1

Z_122=[Z12 -T12;-T12' -T12 ];%p=1, T2, Z2
Z_222=[Z22 -T22;-T22' -T22 ];%p=2, T2, Z2

Q11=[Q1_11+Z_111 1/2*Q1_12;1/2*Q1_12' R11]; %p=1, Q^r1
Q21=[Q2_11+Z_211 1/2*Q2_12;1/2*Q2_12' R21]; %p=2, Q^r1
Q12=[Q1_21+Z_122 1/2*Q1_22;1/2*Q1_22' R12]; %p=1, Q^r2
Q22=[Q2_21+Z_222 1/2*Q2_22;1/2*Q2_22' R22]; %p=2, Q^r2

V31=1/h_1*C1'*Q11*C1+1/h_12*C2'*Q12*C2; %p=1
V32=1/h_1*C1'*Q21*C1+1/h_12*C2'*Q22*C2; %p=2

V1_111=e_1'*(P111+(b111-a111)/10*P111+(b112-a112)/10*P112)*e_1-(1-alpha_1)*v1'*P111*v1; %p=1
V1_112=e_1'*(P112+(b111-a111)/10*P111+(b112-a112)/10*P112)*e_1-(1-alpha_1)*v1'*P112*v1;
V1_121=e_1'*(P121+(b121-a121)/10*P121+(b122-a122)/10*P122)*e_1-(1-alpha_1)*v1'*P121*v1;
V1_122=e_1'*(P122+(b121-a121)/10*P121+(b122-a122)/10*P122)*e_1-(1-alpha_1)*v1'*P122*v1;

V1_211=e_2'*(P211+(b211-a211)/10*P211+(b212-a212)/10*P212)*e_2-(1-alpha_2)*v1'*P211*v1; %p=2
V1_212=e_2'*(P212+(b211-a211)/10*P211+(b212-a212)/10*P212)*e_2-(1-alpha_2)*v1'*P212*v1;
V1_221=e_2'*(P221+(b221-a221)/10*P221+(b222-a222)/10*P222)*e_2-(1-alpha_2)*v1'*P221*v1;
V1_222=e_2'*(P222+(b221-a221)/10*P221+(b222-a222)/10*P222)*e_2-(1-alpha_2)*v1'*P222*v1;

V2_21=[v2' v6']*(1-alpha_1)^h_1*[W12-W11]*[v2' v6']'-[v4' v8']*(1-alpha_1)^h_2*W12*[v4' v8']'...
    +[v1' v5']*W11*[v1' v5']';%p=1
V2_22=[v2' v6']*(1-alpha_2)^h_1*[W22-W21]*[v2' v6']'-[v4' v8']*(1-alpha_2)^h_2*W22*[v4' v8']'...
    +[v1' v5']*W21*[v1' v5']';%p=2

E11=[v1+v9;e_1-v2];%p=1 E1
E12=[v1+v9;e_2-v2];%p=2 E1
E2=[v9;v1-v2];% E2
E3=[v10;v2-v4];% E3
E41=[v1+v9+v10;e_1-v4];%p=1 E4
E42=[v1+v9+v10;e_2-v4];%p=2 E4

phi211=(1-alpha_1)^h_1*Pi2'*[Q1_22-Q1_12]*E11-E2'*Q1_12*Pi11...
    +[(1-alpha_1)^h_1*Pi2'*[Q1_22-Q1_12]*E11-E2'*Q1_12*Pi11]';
phi221=[-E3'*Q1_22*Pi11-(1-alpha_1)^h_2*Pi3'*Q1_22*E41]...
    +[-E3'*Q1_22*Pi11-(1-alpha_1)^h_2*Pi3'*Q1_22*E41]';

phi212=[(1-alpha_2)^h_1*Pi2'*[Q2_22-Q2_12]*E12-E2'*Q2_12*Pi12]...
    +[(1-alpha_2)^h_1*Pi2'*[Q2_22-Q2_12]*E12-E2'*Q2_12*Pi12]';
phi222=[-E3'*Q2_22*Pi12-(1-alpha_2)^h_2*Pi3'*Q2_22*E42]...
    +[-E3'*Q2_22*Pi11-(1-alpha_2)^h_2*Pi3'*Q2_22*E42]';

V3_31=Pi11'*Q1_11*Pi11+(1-alpha_1)^h_1*Pi2'*(Q1_21-Q1_11)*Pi2... 
    -(1-alpha_1)^h_2*Pi3'*Q1_21*Pi3+1/2*(phi211+phi221); %p=1
V3_32=Pi12'*Q2_11*Pi12+(1-alpha_2)^h_1*Pi2'*(Q2_21-Q2_11)*Pi2... 
    -(1-alpha_2)^h_2*Pi3'*Q2_21*Pi3+1/2*(phi212+phi222); %p=2

V4_41=(e_1-v1)'*[h_1^2*Z11+h_12^2*Z12]*(e_1-v1); %p=1
V4_42=(e_2-v1)'*[h_1^2*Z21+h_12^2*Z22]*(e_2-v1); %p=2

V5_51=[v1' (e_1-v1)']*[h_1*R11+h_12^2*R12]*[v1' (e_1-v1)']'; %p=1
V5_52=[v1' (e_2-v1)']*[h_1*R21+h_12^2*R22]*[v1' (e_2-v1)']'; %p=2

V6_61=-C3'*Z_11*C3; %p=1 
V6_62=-C3'*Z_21*C3; %p=2

V7_71=-(1-alpha_1)^h_2*pi1*[Z_12 Y1; Y1' Z_12]*pi1'; %p=1
V7_72=-(1-alpha_2)^h_2*pi1*[Z_22 Y2; Y2' Z_22]*pi1'; %p=2

V8_81=v1'*T13*v1-v2'*T13*v2-C4'*R_113*C4; %p=1
V8_82=v1'*T23*v1-v2'*T23*v2-C4'*R_123*C4; %p=2

V91=-(1-alpha_1)^h_2*(v2'*T14*v2-v3'*[T15-T14]*v3-v4'*T15*v4-pi2*[R_214 S1;S1' R_215]*pi2');%p=1
V92=-(1-alpha_2)^h_2*(v2'*T24*v2-v3'*[T25-T24]*v3-v4'*T25*v4-pi2*[R_224 S2;S2' R_225]*pi2');%p=2

V10_1=F1*(v17-h_2k*(h_2k+1)*v16-h_1k*(h_1k+1)*v15-(h_2k-1)*v11+h_2k*v3)...
    +[F1*(v17-h_2k*(h_2k+1)*v16-h_1k*(h_1k+1)*v15-(h_2k-1)*v11+h_2k*v3)]'; 
 
V10_2=F2*(v17-h_2k*(h_2k+1)*v16-h_1k*(h_1k+1)*v15-(h_2k-1)*v11+h_2k*v3)...
    +[F2*(v17-h_2k*(h_2k+1)*v16-h_1k*(h_1k+1)*v15-(h_2k-1)*v11+h_2k*v3)]'; 


V11_1=(K1*v1-v5)'*M11*(v5-K2*v1)+(K1*v2-v6)'*M12*(v6-K2*v2)+(K1*v3-v7)'*M13*(v7-K2*v3)+(K1*v4-v8)'*M14*(v8-K2*v4)...
    +[(K1*v1-v5)'*M11*(v5-K2*v1)+(K1*v2-v6)'*M12*(v6-K2*v2)+(K1*v3-v7)'*M13*(v7-K2*v3)+(K1*v4-v8)'*M14*(v8-K2*v4)]'...
    +(K1*(v1-v2)-v5+v6)'*D11*(v5-v6-K2*(v1-v2))+(K1*(v2-v3)-v6+v7)'*D12*(v6-v7-K2*(v2-v3))+(K1*(v3-v4)-v7+v8)'*D13*(v7-v8-K2*(v3-v4))...
    +[(K1*(v1-v2)-v5+v6)'*D11*(v5-v6-K2*(v1-v2))+(K1*(v2-v3)-v6+v7)'*D12*(v6-v7-K2*(v2-v3))+(K1*(v3-v4)-v7+v8)'*D13*(v7-v8-K2*(v3-v4))]';

V11_2=(K1*v1-v5)'*M21*(v5-K2*v1)+(K1*v2-v6)'*M22*(v6-K2*v2)+(K1*v3-v7)'*M23*(v7-K2*v3)+(K1*v4-v8)'*M24*(v8-K2*v4)...
    +[(K1*v1-v5)'*M21*(v5-K2*v1)+(K1*v2-v6)'*M22*(v6-K2*v2)+(K1*v3-v7)'*M23*(v7-K2*v3)+(K1*v4-v8)'*M24*(v8-K2*v4)]'...
    +(K1*(v1-v2)-v5+v6)'*D21*(v5-v6-K2*(v1-v2))+(K1*(v2-v3)-v6+v7)'*D22*(v6-v7-K2*(v2-v3))+(K1*(v3-v4)-v7+v8)'*D23*(v7-v8-K2*(v3-v4))...
    +[(K1*(v1-v2)-v5+v6)'*D21*(v5-v6-K2*(v1-v2))+(K1*(v2-v3)-v6+v7)'*D22*(v6-v7-K2*(v2-v3))+(K1*(v3-v4)-v7+v8)'*D23*(v7-v8-K2*(v3-v4))]';
 
V12_1=(N11*v1+N12*v18)'*(e_1-A_1*v1-B_1*v5-C_1*v7)...
    +[(N11*v1+N12*v18)'*(e_1-A_1*v1-B_1*v5-C_1*v7)]';%p=1
V12_2=(N21*v1+N22*v18)'*(e_2-A_2*v1-B_2*v5-C_2*v7)...
    +[(N21*v1+N22*v18)'*(e_2-A_2*v1-B_2*v5-C_2*v7)]';%p=2

Z1=[Z_12 Y1; Y1' Z_12];
Z2=[Z_22 Y2; Y2' Z_22];
Z3=[R_214 S1;S1' R_215];
Z4=[R_224 S2;S2' R_225];

V1=V1_111+V1_112+V1_121+V1_122+V2_21+V3_31+V4_41+V5_51...
    +V6_61+V7_71+V8_81+V91+V10_1+V11_1+V12_1;%p=1

V2=V1_211+V1_212+V1_221+V1_222+V2_22+V3_32+V4_42+V5_52...
    +V6_62+V7_72+V8_82+V92+V10_2+V11_2+V12_2;%p=2
  
V3=V111+V112+V121+V122+V21+V31;
V4=V211+V212+V221+V222+V22+V32;

V5=a121*P121+a122*P122-pho_1*(b111*P111+b111*P112);
V6=a221*P221+a222*P222-pho_2*(b211*P211+b212*P212);

V7=a111*P111+a112*P112-mu_1*(b221*P221+b222*P222);
V8=a211*P211+a212*P212-mu_2*(b121*P121+b122*P122);

W1=W11-mu_1*W12;
W2=W21-mu_2*W22;
W3=Z11-mu_1*Z12;
W4=Z21-mu_2*Z22;
W5=R11-mu_1*R12;
W6=R21-mu_2*R22;
W7=Q1_1-mu_1*Q1_2;
W8=Q1_2-mu_2*Q1_1;
W9=Q2_1-mu_1*Q2_2;
W10=Q2_2-mu_2*Q2_1;

F=[P111>=0.0001*eye(n),P112>=0.0001*eye(n),P121>=0.0001*eye(n),P122>=0.0001*eye(n),
     P211>=0.0001*eye(n),P212>=0.0001*eye(n),P221>=0.0001*eye(n),P222>=0.0001*eye(n),
     Q11>=0.0001*eye(4*n),Q12>=0.0001*eye(4*n),Q21>=0.0001*eye(4*n),Q22>=0.0001*eye(4*n),
     R_113>=0.0001*eye(2*n),R_123>=0.0001*eye(2*n),Z1>=0.0001*eye(6*n),Z2>=0.0001*eye(6*n),
     Z3>=0.0001*eye(4*n),Z4>=0.0001*eye(4*n)];
 
 F=F+[Z11>=0.0001*eye(n),Z12>=0.0001*eye(n),Z21>=0.0001*eye(n),Z22>=0.0001*eye(n),
    W11>=0.0001*eye(2*n),W12>=0.0001*eye(2*n),W21>=0.0001*eye(2*n),W22>=0.0001*eye(2*n),
    R11>=0.0001*eye(2*n),R12>=0.0001*eye(2*n),R21>=0.0001*eye(2*n),R22>=0.0001*eye(2*n)];

F=F+F+[M11>=0.0001*eye(n),M12>=0.0001*eye(n),M13>=0.0001*eye(n),M14>=0.0001*eye(n),
    M21>=0.0001*eye(n),M22>=0.0001*eye(n),M23>=0.0001*eye(n),M24>=0.0001*eye(n),
    D11>=0.0001*eye(n),D12>=0.0001*eye(n),D13>=0.0001*eye(n),D21>=0.0001*eye(n),
    D22>=0.0001*eye(n),D23>=0.0001*eye(n)];


F=F+F+F+[V1<=-0.0001*eye(20*n),V2<=-0.0001*eye(20*n),V3>=0.0001*eye(20*n),V4>=0.0001*eye(20*n),
     V5<=-0.0001*eye(1*n),V6<=-0.0001*eye(1*n),V7<=-0.0001*eye(1*n),V8<=-0.0001*eye(1*n)];
 
F=F+F+F+F+[W1<=-0.0001*eye(2*n),W2<=-0.0001*eye(2*n),W3<=-0.0001*eye(n),W4<=-0.0001*eye(n),W5<=-0.0001*eye(2*n),
    W6<=-0.0001*eye(2*n),W7<=-0.0001*eye(2*n,4*n),W8<=-0.0001*eye(2*n,4*n),W9<=-0.0001*eye(2*n,4*n),W10<=-0.0001*eye(2*n,4*n)];

%% Solve LMI problem
ops = sdpsettings('verbose', 0, 'solver', 'penlab');
result.solution = solvesdp(F, [], ops);

%% Check solution
result.feasible = result.solution.problem == 0;
if result.feasible
    result.status = 'Feasible';
    result.message = 'MPCA-LKF LMI problem solved successfully';
else
    result.status = 'Infeasible';
    result.message = 'MPCA-LKF LMI problem infeasible';
end

%% Save results
result.params = params;
result.timestamp = datetime('now');

end 