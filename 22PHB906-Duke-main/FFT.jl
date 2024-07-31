global function SWAP(a, b)
    newB = a
    a = b
    b = newB
end

function FFT(data::Vector{Float32}, nn::Int, isign::Int)
    n = nn << 1
    j = 1
    if isinteger(log(2,nn))
        for i in 1:2:n-1
            if j > i
                SWAP(data[j],data[i])
                SWAP(data[j+1],data[i+1])
            end
            m = nn
            while m >= 2 && j > m
                j -= m
                m >>= 1
            end
            j += m
        end
        mmax = 2
        while n > mmax
            istep = mmax << 1
            theta = isign * (6.28318530717959/mmax)
            wtemp = sin(0.5*theta)
            wpr = -2.0*wtemp*wtemp
            wpi = sin(theta)
            wr = 1.0
            wi = 0.0
            if isign == 1
                for m in 1:2:mmax-1
                    for i in m:istep:n
                        j = i + mmax
                        tempr = wr*data[j] - wi*data[j+1]
                        tempi = wr*data[j+1] + wi*data[j]
                        data[j] = data[i] - tempr
                        data[j+1] = data[i+1] - tempi
                        data[i] += tempr
                        data[i+1] += tempi
                    end
                    wr = (wtemp = wr)*wpr - wi*wpi + wr
                    wi = wi*wpr + wtemp*wpi + wi
                end
            elseif isign == -1
                for m in 1:2:mmax-1
                    for i in m:istep:n
                        j = i + mmax
                        tempr = wr*data[j]/nn - wi*data[j+1]/nn
                        tempi = wr*data[j+1]/nn + wi*data[j]/nn
                        data[j] = data[i] - tempr
                        data[j+1] = data[i+1] - tempi
                        data[i] += tempr
                        data[i+1] += tempi
                    end
                    wr = (wtemp = wr)*wpr - wi*wpi + wr
                    wi = wi*wpr + wtemp*wpi + wi
                end
            else
                return "invalid isign input"
            end
            mmax = istep
        end
        @show(data)
    else
        return "invalid nn input"
    end
end

data = randn(Float32, 8)

FFT(data, Int(length(data)/2), 1)

