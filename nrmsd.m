function err = nrmsd(y_data,y_guess)

err = sqrt(sum((y_data-y_guess).^2)/length(y_data))/range(y_data);