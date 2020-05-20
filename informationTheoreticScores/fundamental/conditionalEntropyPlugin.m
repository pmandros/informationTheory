function condSha=conditionalEntropyPlugin(samplesX,samplesY)
%CONDITIONALENTROPYPLUGIN plugin estimator for conditional entropy Y given
%X
    assert(length(samplesX)==length(samplesY),'Samples should have the same length');
    entropyY=entropyPlugin(samplesY);
    mi=mutualInformationPlugin(samplesX,samplesY);
    condSha=entropyY-mi;
end