function [fitresult, gof] = createFit(BareLWFreq, BareLWAmp)
%CREATEFIT(BARELWFREQ,BARELWAMP)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : BareLWFreq
%      Y Output: BareLWAmp
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Apr-2014 11:27:45


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( BareLWFreq, BareLWAmp );

% Set up fittype and options.
ft = fittype( 'c+a/(1+((x-x0)/(L/2))^2)', 'coefficients', {'L','a','c','x0'},'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft);
opts.Display = 'Off';
opts.Maxiter = 1000;
opts.Robust = 'LAR';
opts.Algorithm = 'Levenberg-Marquardt';
opts.Lower = [0 0 0 0];
AmpSm = smooth(BareLWAmp,20);
[M,IX]=max(AmpSm);
%[m,iX]=min(BareLWAmp);
m = mean(AmpSm(1:10));

[HW,iHW]=min(abs(AmpSm(1:IX)-(m+(M-m)/2)));
CF = BareLWFreq(IX)
FWHM = 2*abs(BareLWFreq(iHW)-CF)
opts.StartPoint = [FWHM M-m m BareLWFreq(IX)];
opts.Upper = [Inf Inf Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
%yFitData = exp(fitresult(xData));
%h = plot(xData, yFitData, xData, yData );
%legend( h, 'BareLWAmp vs. BareLWFreq', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
%xlabel( 'Frequency (Hz)' );
%%ylabel( 'Amplitude' );
%set(gca,'YScale','log');
%grid on


