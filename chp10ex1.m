Iabc = [1.6  25
        1.0   180
        .9 132];
I012 = abc2sc(Iabc);            % Symmetrical components of phase a
I012p= rec2pol(I012) % Converts rectangular phasors into polar form
