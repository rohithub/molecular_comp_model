function y = biquad_mc(x)

% Implements biquad
B_conc = 0.5;
A_conc = 0;
C_conc = 0;
T_conc = 0.1;
D_conc = 0.1;
R_conc = 0.3;
X_conc = x;
Y_conc = 0;

k_slow = 2;
k_fast = 1;

    for i=1:10      % Run the reactions 10 times
        molecule_level = {'B' 'X'; B_conc X_conc};
        reactions_env = react(molecule_level, k_slow);
        A_conc = reactions_env{2,2};
        C_conc = reactions_env{2,3};

        molecule_level = {'A' 'A'; A_conc A_conc};
        reactions_env = react(molecule_level, k_fast);
        T_conc = reactions_env{2,1};

        molecule_level = {'C' 'C'; C_conc C_conc};
        reactions_env = react(molecule_level, k_fast);
        Y_conc = reactions_env{2,1};

        molecule_level = {'B' 'D'; B_conc D_conc};
        reactions_env = react(molecule_level, k_slow);
        Y_conc = reactions_env{2,2};

        molecule_level = {'R' 'T'; R_conc T_conc};
        reactions_env = react(molecule_level, k_slow);
        D_conc = reactions_env{2,2};
    end
    y = Y_conc;
end