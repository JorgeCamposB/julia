SigTabSize = 400;
SigTabRange = 15.0;
SigTab=[]

function sigma(x)
    return 1/(1 + exp(-x))
end

function InitSigmoidTable()
    DeltaX = SigTabRange/(SigTabSize)
    for i in 0:SigTabSize
        push!(SigTab,sigma(i * DeltaX))
    end
end

function fastSigmoid(x)
    if (x >= SigTabRange)
        return 1.0
    end
    if (x < 0)
        return 1.0 - fastSigmoid(-x)
    end
    frac = modf(x*(SigTabSize-1)/SigTabRange)
    i=frac[2]
    i=convert(Int64,i)
    y1 = SigTab[i]
    y2 = SigTab[i+1]
    return y1 + (y2 - y1) * frac[1]
end

function sigmoid(x)
    return fastSigmoid(x)
end

function inverseSigmoid(y)
    return log(y/(1-y))
end
