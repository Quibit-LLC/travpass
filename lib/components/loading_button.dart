import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      margin: const EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFF34DD5A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (isLoadingState) // Replace isLoadingState with your actual isLoading state variable
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
            const SizedBox(width: 8),
            // Add some spacing between the loading indicator and the text
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w500,
                height: 0.06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
